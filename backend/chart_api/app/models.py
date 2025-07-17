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
    type: ChartType = Field(
            ...,
            description=(
                "Type of chart to generate. "
                "One of: 'bar', 'line', 'pie', 'grouped_bar', 'stacked_bar'."
            )
        )
    x: List[str] = Field(
            ...,
            description=(
                "List of categories or x-axis labels. Must be the same length as 'y'. "
                "For 'grouped_bar' and 'stacked_bar', represents subcategories within groups."
            )
        )
    y: List[float] = Field(
        ...,
        description=(
            "List of numerical values. Must match the length of 'x'. "
            "For 'pie' charts, represents the proportion of each category. "
            "If 'values_are_percentages' is true, these must be in the range [0.0, 1.0]."
        )
    )
    group: Optional[List[str]] = Field(
        None,
        description=(
            "Optional group label for each (x, y) pair. "
            "Required for 'grouped_bar' and 'stacked_bar' charts. "
            "Must match length of 'x' and 'y' if provided."
        )
    )

    title: Optional[str] = Field(None, description="Title displayed above the chart.")
    x_label: Optional[str] = Field(None, description="Label for the horizontal axis.")
    y_label: Optional[str] = Field(None, description="Label for the vertical axis.")
    values_are_percentages: bool = Field(
        False,
        description=(
            "If true and 'type' is 'pie', the 'y' values are expected as "
            "fractions (e.g., 0.25 for 25%). They must sum to approximately 1.0."
        )
    )

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