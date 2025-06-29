import fs from "fs/promises";
import path from "path";
import url from "url";

import logger from "../utils/logger.js"

const TAG = "[ui-data-service]";

const __filename = url.fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const jsonPath = path.join(__dirname, "../data/BS2024.json");

export async function getUiData(chapterId) {
    const fileData = await fs.readFile(jsonPath, "utf-8");
    const data = JSON.parse(fileData);

    if (!chapterId) {
        return data;
    }

    const chapterData = data.capitoli?.find(
        (chapter) => chapter.numero === chapterId
    );

    if (!chapterData) {
        logger.warn(`${TAG} Chapter ${chapterId} not found`);
        throw new ChapterNotFoundError();
    }

    return chapterData
}

export class ChapterNotFoundError extends Error {
    constructor(message = "Chapter not found") {
        super(message);
        this.name = "ChapterNotFoundError";
    }
}