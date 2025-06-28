import { GoogleGenAI } from "@google/genai";
import { LLMInterface } from "./llmInterface.js";

export class GeminiClient extends LLMInterface {
    constructor(apiKey) {
        super();
        this.ai = new GoogleGenAI({ apiKey: apiKey });
        this.model = "gemini-2.0-flash";
    }

    async ask(prompt) {
        const response = await this.ai.models.generateContent(
            {
                model: this.model,
                contents: prompt,
            }
        );
        return response.text
    }
}