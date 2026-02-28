/**
 * Yarlis App ID (YAR) — deterministic hash per app+env
 * Import this anywhere to resolve app identity
 *
 * Usage:
 *   import { getAppId, getVaultPrefix } from '@yarlisc/registry';
 *   const id = getAppId('rtm', 'prod');
 *   // → { yar: 'YAR-RTM-A3F9B2C14D8E', hash: 'a3f9b2c14d8e', vault: 'ypid_rtm_prod' }
 */

import * as crypto from "crypto";

export type DomainCode = "yrl" | "yai" | "mbx" | "sdo" | "rtm" | "yio" | "all";
export type Environment = "prod" | "staging" | "dev";
export type AppType = "firebase-hosting" | "npm-library" | "cloud-run" | "nextjs-vercel" | "chrome-extension";

export interface AppIdentity {
  yar: string;           // YAR-RTM-A3F9B2C14D8E (human readable)
  hash: string;          // a3f9b2c14d8e (12 char hex, stable)
  vault_prefix: string;  // ypid_rtm_prod
  domain: DomainCode;
  env: Environment;
}

export function getAppId(
  domain: DomainCode,
  env: Environment,
  appName: string,
  appType: AppType
): AppIdentity {
  const input = `${domain}:${env}:${appType}:${appName}`;
  const hash = crypto.createHash("sha256").update(input).digest("hex").slice(0, 12);
  
  return {
    yar: `YAR-${domain.toUpperCase()}-${hash.toUpperCase()}`,
    hash,
    vault_prefix: `ypid_${domain}_${env}`,
    domain,
    env,
  };
}

export function getVaultSecretId(
  domain: DomainCode,
  env: Environment,
  secretName: string
): string {
  return `ypid_${domain}_${env}_${secretName}`;
}

export function getSharedSecretId(secretName: string): string {
  return `ypid_all_prod_${secretName}`;
}

// Pre-computed app identities
export const AppRegistry = {
  rapidtriage: {
    prod:    getAppId("rtm", "prod",    "RapidTriageME",  "firebase-hosting"),
    staging: getAppId("rtm", "staging", "RapidTriageME",  "firebase-hosting"),
    dev:     getAppId("rtm", "dev",     "RapidTriageME",  "firebase-hosting"),
  },
  mybotbox: {
    prod:    getAppId("mbx", "prod",    "MyBotBox",       "firebase-hosting"),
    staging: getAppId("mbx", "staging", "MyBotBox",       "firebase-hosting"),
  },
  yarlisai: {
    prod:    getAppId("yai", "prod",    "YarlisAI SDK",   "npm-library"),
  },
  sdods: {
    prod:    getAppId("sdo", "prod",    "sdods Library",  "npm-library"),
  },
  yarlis: {
    prod:    getAppId("yrl", "prod",    "Yarlis Platform","cloud-run"),
  },
} as const;
