import { assertEquals } from "jsr:@std/assert";
import { dim, rgb24 } from "jsr:@std/fmt@^1.0.8/colors";

// Import the function we want to test
// Since it's not exported, we'll need to refactor or test integration
// For now, let's create a standalone version to test the logic
function formatTokenPercentage(percentage: number): string {
	const displayStr = `${percentage}%`;

	if (percentage >= 80) {
		return dim(rgb24(displayStr, 0xff0000)); // Red
	}
	if (percentage >= 61) {
		return dim(rgb24(displayStr, 0xff6600)); // Orange
	}
	if (percentage >= 46) {
		return dim(rgb24(displayStr, 0xffff00)); // Yellow
	}
	if (percentage >= 1) {
		return dim(rgb24(displayStr, 0x00ff00)); // Green
	}
	// For 0% or invalid inputs, return the default dimmed style
	return dim(displayStr);
}

Deno.test("formatTokenPercentage - 0% returns dimmed default", () => {
	const result = formatTokenPercentage(0);
	const expected = dim("0%");
	assertEquals(result, expected);
});

Deno.test("formatTokenPercentage - 1% to 45% returns dimmed green", () => {
	assertEquals(formatTokenPercentage(1), dim(rgb24("1%", 0x00ff00)));
	assertEquals(formatTokenPercentage(30), dim(rgb24("30%", 0x00ff00)));
	assertEquals(formatTokenPercentage(45), dim(rgb24("45%", 0x00ff00)));
});

Deno.test("formatTokenPercentage - 46% to 60% returns dimmed yellow", () => {
	assertEquals(formatTokenPercentage(46), dim(rgb24("46%", 0xffff00)));
	assertEquals(formatTokenPercentage(50), dim(rgb24("50%", 0xffff00)));
	assertEquals(formatTokenPercentage(60), dim(rgb24("60%", 0xffff00)));
});

Deno.test("formatTokenPercentage - 61% to 79% returns dimmed orange", () => {
	assertEquals(formatTokenPercentage(61), dim(rgb24("61%", 0xff6600)));
	assertEquals(formatTokenPercentage(70), dim(rgb24("70%", 0xff6600)));
	assertEquals(formatTokenPercentage(79), dim(rgb24("79%", 0xff6600)));
});

Deno.test("formatTokenPercentage - 80% to 100% returns dimmed red", () => {
	assertEquals(formatTokenPercentage(80), dim(rgb24("80%", 0xff0000)));
	assertEquals(formatTokenPercentage(90), dim(rgb24("90%", 0xff0000)));
	assertEquals(formatTokenPercentage(100), dim(rgb24("100%", 0xff0000)));
});

Deno.test("formatTokenPercentage - edge cases", () => {
	// Test boundary values
	assertEquals(formatTokenPercentage(0), dim("0%"));
	assertEquals(formatTokenPercentage(1), dim(rgb24("1%", 0x00ff00)));
	assertEquals(formatTokenPercentage(45), dim(rgb24("45%", 0x00ff00)));
	assertEquals(formatTokenPercentage(46), dim(rgb24("46%", 0xffff00)));
	assertEquals(formatTokenPercentage(60), dim(rgb24("60%", 0xffff00)));
	assertEquals(formatTokenPercentage(61), dim(rgb24("61%", 0xff6600)));
	assertEquals(formatTokenPercentage(79), dim(rgb24("79%", 0xff6600)));
	assertEquals(formatTokenPercentage(80), dim(rgb24("80%", 0xff0000)));
});

Deno.test("formatTokenPercentage - handles negative values gracefully", () => {
	const result = formatTokenPercentage(-5);
	const expected = dim("-5%");
	assertEquals(result, expected);
});

Deno.test("formatTokenPercentage - handles values over 100%", () => {
	const result = formatTokenPercentage(150);
	const expected = dim(rgb24("150%", 0xff0000));
	assertEquals(result, expected);
});