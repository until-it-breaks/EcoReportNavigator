from enum import Enum
from typing import List, Optional
from pydantic import BaseModel, Field, model_validator

class ChartType(str, Enum):
    BAR = "bar"
    LINE = "line"
    PIE = "pie"
    GROUPED_BAR = "grouped_bar"
    STACKED_BAR = "stacked_bar"

class ChartRequest(BaseModel):
    type: ChartType = Field(...)
    x: List[str] = Field(...)
    y: List[float] = Field(...)
    group: Optional[List[str]] = None

    title: Optional[str] = None
    x_label: Optional[str] = None
    y_label: Optional[str] = None
    values_are_percentages: bool = False

    @model_validator(mode="before")
    def validate_request_data(cls, values):
        x, y, group, chart_type = (
            values.get("x"),
            values.get("y"),
            values.get("group"),
            values.get("type"),
        )
        if len(x) != len(y):
            raise ValueError("'x' and 'y' must have the same length")

        if chart_type in (ChartType.GROUPED_BAR, ChartType.STACKED_BAR):
            if group is None:
                raise ValueError(f"'group' is required when type is '{chart_type.value}'")
            if len(group) != len(x):
                raise ValueError("'group' must be the same length as 'x' and 'y'")

        if values.get("values_are_percentages"):
            for i, val in enumerate(values.get("y", [])):
                if not isinstance(val, (int, float)):
                    raise ValueError(f"'y[{i}]' must be a float when values_are_percentages is True")
                if not (0.0 <= val <= 1.0):
                    raise ValueError(f"'y[{i}]' must be between 0.0 and 1.0 (got {val})")

        return values