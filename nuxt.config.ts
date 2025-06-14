import { fileURLToPath } from "url";

export default defineNuxtConfig({
  compatibilityDate: '2025-06-10',
  // Disable strict
  typescript: {
    strict: false,
  },
  /*
  alias: {
      "@": "/",
      "~prismaClient": fileURLToPath(new URL('./generated/prisma', import.meta.url))
  },
  */
  app: {
    head: {
      title: "Blog Post App",
      meta: [
        { charset: "utf-8" },
        { name: "viewport", content: "width=device-width, initial-scale=1" },
        { name: "description", content: "" },
      ],
      link: [{ rel: "icon", type: "image/x-icon", href: "/favicon.ico" }],
    },
  },
  // ssr: true,
  nitro: {
    
    replace: {
      'import * as process': 'import * as processUnused',
    },
    preset: "node-server", // Ensures full Node.js support (needed for Prisma)
    esbuild: {
      options: {
        target: "es2022", 
      },
    },
    externals: {
      external: [
        ".prisma", // ignore Prisma internals
        "@prisma/client", // don't bundle Prisma
        "prisma", // don't bundle Prisma CLI
        "process", // Node.js process module
      ],
    },
  }
});
