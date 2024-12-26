class Reviewer
  attr_reader :client
  attr_accessor :prompt, :raw_response, :parsed_response

  def default_prompt
    <<~PROMPT
      You are an AI code reviewer that must output ONLY valid JSON.

      Please review the following code in three dimensions:

      1. Refactoring: Does the code need refactoring to achieve the best quality? Please provide a grade from 1 to 5.
      2. Performance: Does the code need performance improvement? Please provide a grade from 1 to 5.
      3. Security: Does the code need security improvement? Please provide a grade from 1 to 5.

      Additionally, provide an overall grade and an explanation of what is good and bad about the code. Each review MUST include:
      - What could be improved
      - Code examples showing the current problematic code
      - Code examples showing the improved version
      - Explanation of why the improved version is better

      Examples should go inside the "review" key of each section.

      #{prompt_return_structure}
    PROMPT
  end

  def prompt_return_structure
    <<~PROMPT
      STRICT INSTRUCTION: Respond with raw JSON only. No introduction text, no explanation, no markdown, no "Here's the response", nothing else.

      Your response must start with { and end with } with no other characters before or after.

      Review the code for refactoring, performance, and security using this exact JSON structure:
      {
        "overall": {
          "grade": <float 1-5>,
          "review": <string>
        },
        "refactoring": {
          "grade": <float 1-5>,
          "review": <string>
        },
        "performance": {
          "grade": <float 1-5>,
          "review": <string>
        },
        "security": {
          "grade": <float 1-5>,
          "review": <string>
        }
      }

      REMEMBER: Output raw JSON only. Any additional text will break the system.
    PROMPT
  end
end
