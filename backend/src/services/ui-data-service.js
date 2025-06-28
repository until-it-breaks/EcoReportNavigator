import fs from "fs/promises";
import path from "path";
import url from "url";

import logger from "../utils/logger.js"

const __filename = url.fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const jsonPath = path.join(__dirname, "../data/BS2024.json");

export async function getUiData(chapterId) {
    try {
        const fileData = await fs.readFile(jsonPath, "utf-8");
        const data = JSON.parse(fileData);

        if (!chapterId) {
            return data;
        }

        const chapterData = data.capitoli?.find(
            (c) => c.numero === chapterId
        );

        if (!chapterData) {
            logger.warn(`Chapter not found: ${chapterId}`);
            throw new ChapterNotFoundError();
        }

        return chapterData
    } catch (err) {
        logger.error(`Failed to read UI data: ${err.message}`);
        throw err
    }

}

export class ChapterNotFoundError extends Error {
    constructor(message = "Chapter not found") {
        super(message);
        this.name = "ChapterNotFoundError";
    }
}