import path from "path";
import { fileURLToPath } from "url";

const currentFilePath = fileURLToPath(import.meta.url);
const currentDir = path.dirname(currentFilePath);

export const config = {
  host: "0.0.0.0",
  port: 8080,
  dataFilePath: path.resolve(currentDir, "./data/BS2024.json"),
  routes: {
    data: "/data",
  },
};