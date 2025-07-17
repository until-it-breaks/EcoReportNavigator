import pandas as pd
import altair as alt
from app.models import ChartRequest, ChartType

CHART_SIZE = 400

def generate_chart(req: ChartRequest) -> alt.Chart:
    if req.type == ChartType.PIE:
        return _generate_pie_chart(req)
    else:
        return _generate_standard_chart(req)

def _generate_standard_chart(req: ChartRequest) -> alt.Chart:
    df = pd.DataFrame({
        "x": req.x,
        "y": req.y,
        "group": req.group,
    })

    if req.type == ChartType.BAR:
        chart = (
            alt.Chart(df)
            .mark_bar()
            .encode(
                x=alt.X("x:N", title=req.x_label),
                y=alt.Y("y:Q", title=req.y_label),
                color=alt.Color("x:N", legend=None),
            )
        )
    elif req.type == ChartType.LINE:
        chart = (
            alt.Chart(df)
            .mark_line(point=True)
            .encode(
                x=alt.X("x:N", title=req.x_label),
                y=alt.Y("y:Q", title=req.y_label),
            )
        )
    elif req.type == ChartType.GROUPED_BAR:
        chart = (
            alt.Chart(df)
            .mark_bar()
            .encode(
                x=alt.X("x:N", title=req.x_label),
                y=alt.Y("y:Q", title=req.y_label),
                xOffset=alt.XOffset("group:N"),
                color=alt.Color("group:N", legend=alt.Legend(title="Group")),
            )
        )
    elif req.type == ChartType.STACKED_BAR:
        chart = (
            alt.Chart(df)
            .mark_bar()
            .encode(
                x=alt.X("x:N", title=req.x_label),
                y=alt.Y("y:Q", stack="zero", title=req.y_label),
                color=alt.Color("group:N", legend=alt.Legend(title="Series")),
            )
        )
    else:
        raise ValueError(f"Unsupported chart type: {req.type}")

    if req.title:
        chart = chart.properties(title=req.title)

    return chart.properties(width=CHART_SIZE, height=CHART_SIZE)

def _generate_pie_chart(req: ChartRequest) -> alt.Chart:
    df = pd.DataFrame({"category": req.x, "value": req.y})

    if req.values_are_percentages:
        df["percent"] = df["value"]
    else:
        total = df["value"].sum()
        if total == 0:
            raise ValueError("Sum of values for pie chart cannot be zero")
        df["percent"] = df["value"] / total

    base = alt.Chart(df).encode(
        theta=alt.Theta("value:Q", stack=True),
        color=alt.Color("category:N", legend=alt.Legend(title="Category")),
    )

    pie = base.mark_arc(
        outerRadius=120,
        stroke='white',
        strokeWidth=1
    )

    text = base.mark_text(radius=140, size=14).encode(
        text=alt.Text("percent:Q", format=".1%")
    )

    chart = pie + text

    if req.title:
        chart = chart.properties(title=req.title)

    return chart.properties(width=CHART_SIZE, height=CHART_SIZE)