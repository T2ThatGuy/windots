/// <reference types="vite/client" />

interface ImportMetaEnv {
    readonly VITE_LAPTOP_MODE: string | unknown;
}

interface ImportMeta {
    readonly env: ImportMetaEnv;
}
