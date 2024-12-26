class BedrockReviewer < Reviewer
  def initialize(content)
    @content = content

    @client = Aws::BedrockRuntime::Client.new(
      region: ENV["AWS_REGION"],
      access_key_id: ENV["AWS_ACCESS_KEY"],
      secret_access_key: ENV["AWS_SECRET_ACCESS_KEY"]
    )

    @prompt = default_prompt
  end

  def review
    @raw_response = invoke_model.body.read
    @parsed_response = JSON.parse(@raw_response)
    JSON.parse(@parsed_response.dig("content", 0, "text"))
  end

  private

    def invoke_model
      @client.invoke_model(model_id: "anthropic.claude-3-5-sonnet-20240620-v1:0", body: {
      anthropic_version: "bedrock-2023-05-31",
      max_tokens: 200_000,
      messages: [
        {
          role: :user,
          content: [
            {
              type: :text,
              text: prompt
            }
          ]
        },
        {
          role: :user,
          content: [
            {
              type: :text,
              text: @content
            }
          ]
        }
      ]
    }.to_json)
    end
end
