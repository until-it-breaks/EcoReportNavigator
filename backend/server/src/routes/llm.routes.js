import express from "express"

import logger from "../utils/logger.js";

const TAG = "[llm-routes]";

export default function createLLMRoute(llmClient) {
    const router = express.Router()
    router.post("/", async (req, res) => {
    logger.info(`${TAG} ${req.method} ${req.originalUrl} from [${req.ip}]`);
        const { prompt } = req.body;
        try {
            const answer = await llmClient.ask(prompt);
            res.json({ answer });
        } catch (err) {
            logger.warn(`${TAG} LLM error: ${err}`);
            res.status(500).json({ error: "LLM failed to respond" });
        }
    });
    return router
}