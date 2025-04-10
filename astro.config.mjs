// @ts-check
import { defineConfig } from "astro/config";
import mdx from "@astrojs/mdx";
import sitemap from "@astrojs/sitemap";
import icon from "astro-icon";
import tailwindcss from "@tailwindcss/vite";

// https://astro.build/config
export default defineConfig({
  site: "https://kinzoku.dev",
  integrations: [mdx(), sitemap(), icon()],
  markdown: {
    syntaxHighlight: "prism",
  },
  vite: {
    plugins: [tailwindcss()],
  },
});
