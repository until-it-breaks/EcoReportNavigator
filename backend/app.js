import express from "express"
import cors from "cors"
import dotenv from "dotenv"

import GeminiClient from "./src/llm/gemini-client.js"
import createLLMRoute from "./src/routes/llm.routes.js"
import uiDataRoute from "./src/routes/ui-data.routes.js";

import logger from "./src/utils/logger.js";

const TAG = "[startup]";

dotenv.config();

const app = express();
app.use(cors());
app.use(express.json());

const llm = new GeminiClient(process.env.GEMINI_API_KEY);

app.use("/ask", createLLMRoute(llm));
logger.info(`${TAG} Mounted /ask route`);
app.use("/ui-data", uiDataRoute);
logger.info(`${TAG} Mounted /ui-data route`);

const PORT = process.env.PORT || 8080;

const server = app.listen(PORT, "localhost", () => {
    const { address, port } = server.address();
    const host = address.includes(":") ? `[${address}]` : address;
    logger.info(`${TAG} Server running at http://${host}:${port}`);
})