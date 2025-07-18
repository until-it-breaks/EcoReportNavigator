import express from "express"
import cors from "cors"

import createChapterDataRoute from "./routes/data.ts";
import { ChapterDataService } from "./services/chapter-data-service.js";

import logger from "./utils/logger.ts";
import { config } from "./config.ts";

const TAG = "[Startup]";

async function main() {
    const app = express();
    app.use(cors());
    app.use(express.json());

    const chapterDataService = new ChapterDataService(config.dataFilePath);

    app.use(config.routes.data, createChapterDataRoute(chapterDataService));
    logger.info(`${TAG} Mounted ${config.routes.data} route`);

    app.listen(config.port, config.host, () => {
    logger.info(`${TAG} Server running at http://${config.host}:${config.port}`);
    });

    process.on("SIGINT", () => {
        chapterDataService.disposeWatcher();
        process.exit();
    });
}

main().catch(err => {
  logger.error(`${TAG} Failed to start app: ${err.message}`);
  process.exit(1);
});