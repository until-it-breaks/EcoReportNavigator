import express from "express"
import { getUIData as getUiData, ChapterNotFoundError } from "../services/ui-data-service.js"

import logger from "../utils/logger.js";

const router = express.Router();

router.get("/", async (req, res) => {
    try {
        const chapterParam = req.query.chapterId;
        const chapterId = chapterParam ? Number(chapterParam) : undefined;

        logger.info(`GET /ui-data - chapterId=${chapterParam ?? "all"}`);

        if (chapterParam && isNaN(chapterId)) {
            logger.warn(`Invalid chapter id received: ${chapterParam}`);
            return res.status(400).json({ error: "Invalid chapter id" });
        }

        const data = await getUiData(chapterId);
        res.json(data);
    } catch (err) {
        if (err instanceof ChapterNotFoundError) {
            logger.warn(`Chapter not found: ${chapterId}`);
            res.status(404).json({ error: err.message });
        } else {
            logger.error(`Unexpected error in /ui-data: ${err.message}`);
            res.status(500).json({ error: "Failed to load UI data" });
        }
    }
});

export default router