import express from "express"
import { getUiData, ChapterNotFoundError } from "../services/ui-data-service.js"

import logger from "../utils/logger.js";

const TAG = "[ui-data-route]";

const router = express.Router();

router.get("/", async (req, res) => {
    const chapterParam = req.query.chapterId;
    const chapterId = chapterParam ? Number(chapterParam) : undefined;
    try {
        logger.info(`${TAG} ${req.method} ${req.originalUrl} from [${req.ip}]`);

        if (chapterParam && isNaN(chapterId)) {
            logger.warn(`${TAG} Invalid chapter id received from [${req.ip}]`);
            return res.status(400).json({ error: "Invalid chapter id" });
        }

        const data = await getUiData(chapterId);
        res.json(data);
    } catch (err) {
        if (err instanceof ChapterNotFoundError) {
            res.status(404).json({ error: err.message });
        } else {
            res.status(500).json({ error: "Failed to load UI data" });
        }
    }
});

export default router