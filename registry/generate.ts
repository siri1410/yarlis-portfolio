#!/usr/bin/env npx ts-node
/**
 * Yarlis App Registry Generator
 * Reads app-registry.yaml → outputs:
 *   - Per-app hash (deterministic, stable)
 *   - GitHub Actions workflow per app
 *   - Vault secret list per app
 *   - @sdods/@yarlisai integration report
 *
 * Usage: npx ts-node registry/generate.ts
 */

import * as fs from "fs";
import * as path from "path";
import * as crypto from "crypto";
import * as yaml from "js-yaml";

interface AppEnv {
  url?: string;
  firebase_project?: string;
  vault_prefix: string;
  gcp_sa?: string;
  secrets: string[];
}

interface SdodsIntegration {
  package: string;
  usage: string;
  wired: boolean;
}

interface App {
  name: string;
  code: string;
  domain: string;
  domain_code: string;
  app_type: string;
  template: string;
  repo: string;
  npm_scope?: string;
  packages?: string[];
  sdods_integrations: SdodsIntegration[];
  yarlisai_integrations: SdodsIntegration[];
  environments: Record<string, AppEnv>;
  ci_overrides?: Record<string, unknown>;
}

interface Registry {
  apps: App[];
  app_types: Record<string, {
    ci_steps: string[];
    sdods_recommended: string[];
    required_secrets: string[];
  }>;
}

// Deterministic hash per app (stable across runs)
function appHash(app: App, env: string): string {
  const input = `${app.domain_code}:${env}:${app.app_type}:${app.name}`;
  return crypto.createHash("sha256").update(input).digest("hex").slice(0, 12);
}

// Generate YAR ID: YAR-<DOMAIN>-<HASH>
function yarId(app: App, env: string): string {
  return `YAR-${app.domain_code.toUpperCase()}-${appHash(app, env).toUpperCase()}`;
}

const registryPath = path.join(__dirname, "app-registry.yaml");
const registry = yaml.load(fs.readFileSync(registryPath, "utf8")) as Registry;

console.log("\n🔱 YARLIS APP REGISTRY\n" + "=".repeat(60));

const report: Record<string, unknown>[] = [];

for (const app of registry.apps) {
  const appType = registry.app_types[app.app_type];
  
  console.log(`\n📦 ${app.name}`);
  console.log(`   Code: ${app.code} | Type: ${app.app_type} | Template: ${app.template}`);
  console.log(`   Repo: github.com/${app.repo}`);
  
  for (const [env, envConfig] of Object.entries(app.environments)) {
    const hash = appHash(app, env);
    const yar = yarId(app, env);
    
    console.log(`\n   [${env.toUpperCase()}] ${yar}`);
    console.log(`     Hash: ${hash}`);
    console.log(`     Vault prefix: ${envConfig.vault_prefix}`);
    console.log(`     Secrets: ${envConfig.secrets.length}`);
    if (envConfig.url) console.log(`     URL: ${envConfig.url}`);
  }

  // @sdods integration status
  const unwired = app.sdods_integrations.filter(i => !i.wired);
  if (unwired.length > 0) {
    console.log(`\n   ⚠️  @sdods NOT YET WIRED (${unwired.length}):`);
    unwired.forEach(i => console.log(`      ${i.package} — ${i.usage}`));
  }

  // CI steps
  console.log(`\n   CI steps: ${appType?.ci_steps?.join(" → ") || "custom"}`);

  report.push({
    name: app.name,
    code: app.code,
    app_type: app.app_type,
    template: app.template,
    envs: Object.fromEntries(
      Object.entries(app.environments).map(([env, cfg]) => [
        env,
        { yar_id: yarId(app, env), hash: appHash(app, env), vault_prefix: cfg.vault_prefix, secrets: cfg.secrets }
      ])
    ),
    sdods_wired: app.sdods_integrations.filter(i => i.wired).length,
    sdods_pending: app.sdods_integrations.filter(i => !i.wired).length,
  });
}

// Write generated report
const outPath = path.join(__dirname, "generated/registry-report.json");
fs.mkdirSync(path.dirname(outPath), { recursive: true });
fs.writeFileSync(outPath, JSON.stringify(report, null, 2));

console.log("\n\n" + "=".repeat(60));
console.log(`✅ Registry report → registry/generated/registry-report.json`);
console.log(`📊 Total apps: ${registry.apps.length}`);
console.log(`🔗 @sdods pending wires: ${report.reduce((a, r: any) => a + r.sdods_pending, 0)}`);
