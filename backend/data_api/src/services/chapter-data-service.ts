import { readFile } from "fs/promises";
import fs from "fs";

import logger from "../utils/logger.js";
import type { Chapter } from "../models/chapter.ts";
import type { TopicMetadata } from "../models/topic-metadata.ts";
import type { Topic } from "../models/topic.ts";

const TAG = "[ChapterDataService]";

export class NotFoundError extends Error {
    constructor(message: string) {
        super(message);
        this.name = "NotFoundError";
    }
}

export class ChapterDataService {
    private jsonPath: string;
    private cachedData: Chapter[] | null = null;

    constructor(jsonPath: string) {
        this.jsonPath = jsonPath;
        this.init().catch(err => {
            logger.error(`${TAG} Failed to init service: ${err.message}`);
        });
    }

    private async init(): Promise<void> {
        await this.load();
        this.initWatcher();
    }

    private async load(): Promise<void> {
        const fileData = await readFile(this.jsonPath, "utf-8");
        this.cachedData = JSON.parse(fileData);
        logger.info(`${TAG} Data loaded from ${this.jsonPath}`);
    }

    private async ensureLoaded(): Promise<void> {
        if (!this.cachedData) {
            await this.load();
        }
    }

    async reload(): Promise<void> {
        logger.info(`${TAG} Reloading data`);
        await this.load();
    }

    private initWatcher(): void {
        fs.watchFile(this.jsonPath, async (curr, prev) => {
            if (curr.mtime !== prev.mtime) {
                logger.info(`${TAG} Detected change in data file. Reloading...`);
                try {
                    await this.reload();
                } catch (err: unknown) {
                    const message = err instanceof Error ? err.message : String(err);
                    logger.error(`${TAG} Failed to reload data: ${message}`);
                }
            }
        });
    }

    disposeWatcher(): void {
        fs.unwatchFile(this.jsonPath);
        logger.info(`${TAG} Stopped watching ${this.jsonPath}`);
    }

    async getAllChapters(): Promise<Chapter[]> {
        await this.ensureLoaded();
        return this.cachedData ?? [];
    }

    async getChapter(chapterId: number): Promise<Chapter> {
        await this.ensureLoaded();

        const chapter = this.cachedData?.find((c) => c.numero === chapterId);
        if (!chapter) {
            throw new NotFoundError(`Chapter not found`);
        }
        return chapter;
    }

    async getChapterTopicsMetadata(chapterId: number): Promise<TopicMetadata[]> {
        const chapter = await this.getChapter(chapterId);
        const topics = chapter.topics;

        return Object.entries(topics).map(([key, topic]) => ({
            key: key,
            label: topic.label,
            description: topic.description,
        }))
    }

    async getChapterTopic(chapterId: number, key: string): Promise<Topic> {
        const chapter = await this.getChapter(chapterId);
        const topic = chapter.topics[key];
        if (topic === undefined) {
            throw new NotFoundError(`Topic '${key}' not found in chapter ${chapterId}`);
        }
        return topic;
    }
}