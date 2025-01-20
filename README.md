# LLMClimate

LLMClimate is a code analysis tool that reviews repository files using AI to provide grades and recommendations for code quality, refactoring, performance, and security.

## Description

LLMClimate automatically clones repositories, analyzes their code files, and provides comprehensive reviews across multiple categories:
- Overall code quality
- Refactoring suggestions
- Performance optimization
- Security considerations

The tool supports both GitHub and GitLab repositories and can be configured to analyze specific file types while excluding certain patterns.

## Installation

1. Clone the repository:
```bash
git clone https://github.com/yourusername/llmclimate.git
cd llmclimate
```

2. Install dependencies:
```bash
bundle install
```

3. Set up your database:
```bash
rails db:create
rails db:migrate
```

4. Start the server:
```bash
FILE_EXTENSIONS='py,rb,js,css,erb' FILE_EXCLUSION='/test/dummy|db/migrate|db/' AWS_REGION='us-east-1' AWS_ACCESS_KEY='ACCESS_KEY' AWS_SECRET_ACCESS_KEY='SECRET_ACCESS_KEY' rails s
```

## Config SAML SSO

Copy saml.yml.example to saml.yml and change the attributes to it