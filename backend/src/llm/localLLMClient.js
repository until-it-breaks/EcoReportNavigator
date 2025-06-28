import axios from "axios";
import { LLMInterface } from "./llmInterface.js";

export class LocalLLMClient extends LLMInterface {
  constructor(baseURL) {
    super();
    this.baseURL = baseURL;
  }

  async ask(prompt) {
    const response = await axios.post(`${this.baseURL}/completion`, {
      prompt,
      max_tokens: 256,
    });

    return response.data.choices[0].text;
  }
}