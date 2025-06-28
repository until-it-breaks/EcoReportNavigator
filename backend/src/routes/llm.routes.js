import express from "express"

const router = express.Router()

export default function createLLMRoute(llmClient) {
    router.post("/ask", async (req, res) => {
        const { prompt } = req.body;

        try {
            const answer = await llmClient.ask(prompt);
            res.json({ answer });
        } catch (err) {
            console.error("LLM error:", err);
            res.status(500).json({ error: "LLM failed to respond" });
        }
    });

    return router
}