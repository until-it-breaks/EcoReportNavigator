import express from "express"
import cors from "cors"
import dotenv from "dotenv"

import { GeminiClient } from "./src/llm/geminiClient.js"
import { LocalLLMClient } from "./src/llm/localLLMClient.js"
import createLLMRoute from "./src/routes/llm.routes.js"
import uiDataRoute from "./src/routes/ui-data.routes.js";

dotenv.config();

const app = express();
app.use(cors());
app.use(express.json());

const useLocal = process.env.USE_LOCAL === "true";

const llm = useLocal ? new LocalLLMClient("http://localhost:8080") : new GeminiClient(process.env.GEMINI_API_KEY);

app.use("/ask", createLLMRoute(llm));
app.use("/ui-data", uiDataRoute);

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => console.log(`Server running on port ${PORT}`));
