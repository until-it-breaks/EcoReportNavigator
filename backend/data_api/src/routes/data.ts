import express, { type Request, type Response } from "express";
import logger from "../utils/logger.ts";
import { ChapterDataService, NotFoundError } from "../services/chapter-data-service.ts";

const TAG = "[DataRoute]";

function handleRequest(
    tag: string,
    handler: (req: Request, res: Response) => Promise<unknown>
) {
    return async (req: Request, res: Response) => {
        logger.info(`${tag} ${req.method} ${req.baseUrl}${req.path} from [${req.ip}]`);

        try {
            await handler(req, res);
        } catch (err: unknown) {
            if (err instanceof NotFoundError) {
                return res.status(404).json({ error: err.message });
            }

            const message = err instanceof Error ? err.message : String(err);
            logger.error(`${tag} Unexpected error: ${message}`);
            res.status(500).json({ error: "Internal server error" });
        }
    }
}

export default function createChapterDataRoute(chapterDataService: ChapterDataService) {
    const router = express.Router();

    // GET / - all chapters
    router.get("/", handleRequest(TAG, async (_req, res) => {
        const data = await chapterDataService.getAllChapters();
        res.json(data);
    }));

    // GET /:chapterId - specific chapter
    router.get("/:chapterId", handleRequest(TAG, async (req, res) => {
        const chapterId = Number(req.params.chapterId);
        const data = await chapterDataService.getChapter(chapterId);
        res.json(data);
    }));

    // GET /:chapterId/keys - chapter data keys
    router.get("/:chapterId/keys", handleRequest(TAG, async (req, res) => {
        const chapterId = Number(req.params.chapterId);
        const keys = await chapterDataService.getChapterDataKeys(chapterId);
        res.json(keys);
    }));

    // GET /:chapterId/keys/:key - specific chapter data chunk
    router.get("/:chapterId/keys/:key", handleRequest(TAG, async (req, res) => {
        const chapterId = Number(req.params.chapterId);
        const key = req.params.key;
        const chunk = await chapterDataService.getChapterDataChunk(chapterId, key);
        res.json({ key, data: chunk });
    }));

    return router;
}
