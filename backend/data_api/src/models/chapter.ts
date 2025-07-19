import type { Topic } from "./topic.ts";

export interface Chapter {
  numero: number;
  nome: string;
  topics: Record<string, Topic>;
}