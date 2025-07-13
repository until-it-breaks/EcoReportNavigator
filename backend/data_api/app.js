import express from "express"
import cors from "cors"

import uiDataRoute from "./src/routes/ui-data.routes.js";

import logger from "./src/utils/logger.js";

const TAG = "[startup]";

const app = express();
app.use(cors());
app.use(express.json());

app.use("/ui-data", uiDataRoute);
logger.info(`${TAG} Mounted /ui-data route`);

const PORT = 8080;

const server = app.listen(PORT, "0.0.0.0", () => {
    const { address, port } = server.address();
    const host = address.includes(":") ? `[${address}]` : address;
    logger.info(`${TAG} Server running at http://${host}:${port}`);
})