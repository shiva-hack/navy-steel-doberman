# 🌐 Rails-React Q&A Application: OpenAI-Powered PDF Analysis

This Rails-React application uniquely combines the powerful backend capabilities of Rails with the dynamic frontend features of React. Its primary function is to analyze and process PDF manuscripts, allowing users to ask questions and receive answers generated by OpenAI technology. The application excels in comprehending intricate codebases, utilizing APIs for complex tasks, and smoothly fusing Rails with React for an enhanced user experience.

## 🔗 Public URL

- The project could be publicly accessed at https://navy-steel-doberman.onrender.com.

## 🎯 Core Features

- **📄 Advanced PDF Processing**: Utilizing the [`pdf_embed.rake`](/lib/tasks/pdf_embed.rake) script, the app expertly formats a PDF file, extracts its text, and segments it into manageable chunks. These chunks are then stored in a PostgreSQL database for efficient retrieval. We demonstrate this using [`blog.pdf`](/lib/assets/blog.pdf), a thought-provoking article on Engineering Excellence.

- **🔍 Intelligent Backend Query Handling**: The application's backend smartly fetches the most relevant text segments from the database in response to user queries. These segments are then sent to OpenAI, which crafts accurate and context-aware answers.

- **🖥️ Intuitive Frontend Experience**: The [`ChatInterface.jsx`](/app//javascript/react/src/components/ChatInterface.jsx) component, styled with Tailwind CSS, offers a clean and user-friendly chat interface. This enriches user interaction and query handling.

## 🔑 Key Files

- [`ChatInterface.jsx`](/app//javascript/react/src/components/ChatInterface.jsx): The core of the React frontend, mounted using [`remount`](https://www.npmjs.com/package/remount).
- [`pdf_embed_controller.rb`](/app/controllers/pdf_embed_controller.rb): Manages the embedding process of the PDF file.
- [`questions_controller.rb`](/app/controllers/questions_controller.rb): Handles user queries and interactions.

## 🚦 Application Routes

- POST `/questions/ask`: A specialized route for submitting questions.
- POST `/questions`: Allows posting of new questions.
- GET `/questions`: Displays all posted questions.
- DELETE `/questions/:id`: Removes a specific question.
- GET `/up`: A health check endpoint confirming application status.
- GET `/`: The primary entry point of the app, leading to the home controller's index action.

## 🛠️ Setting Up

Follow these instructions to get the application running on your local machine for development and testing.

### 📋 Requirements

- Ruby (version in [`.ruby-version`](.ruby-version))
- Rails (version in [`Gemfile`](Gemfile))
- PostgreSQL with pgvector (Docker setup command provided)
  ```bash
  docker run -d -p 5432:5432 -e POSTGRES_PASSWORD=postgres --name my_gpt_postgres ankane/pgvector
  ```

### 🧰 Installation Process

Clone the repository, then execute these commands in the project directory:

**Install Dependencies**

```bash
bundle install
```

**Database Setup**

```bash
rails db:create
rails db:migrate
```

**Edit Credentials to set the OpenAI secrets**
```bash
rails credentials:edit
```

**Start Development Server**

```bash
./bin/dev
```

The application is now accessible at http://localhost:3000.

## 📘 PDF Embedding Instructions

To process and embed a PDF into the database, use:

```bash
./bin/rake "pdf:embed[filepath]"
```

_Note: Replace "filepath" with your PDF file's path._

## 🗒️ Repository Setup

This project was initiated using:

```bash
rails new navy-steel-doberman --database=postgresql --css=tailwind -j=esbuild
```

## Some Questions that could be asked

Based on the contents of the PDF, which focuses on the concept of Engineering Excellence (EEx) in software development, here are some potential questions that could be asked:
- What is Engineering Excellence?
- What are the primary objectives of the Engineering Excellence (EEx) Team as outlined in the document?
- How does the document describe the transition from 'Building the right product' to 'Building the product right' in the context of software development?
- Can you summarize the four pillars of the Engineering Excellence Team mentioned in the PDF?
- How does the document emphasize the importance of craftsmanship in engineering excellence?
- What are some of the key challenges and responsibilities of the Engineering Excellence Team in improving engineering practices?
- How does the document address the role of leadership in fostering engineering excellence?
- What strategies does the document suggest for improving productivity and effectiveness in software engineering teams?
- How is the concept of happiness for engineers addressed in the context of engineering excellence according to the PDF?
- Can you provide an overview of the initial plans outlined for the Engineering Excellence Team in the document?
- How does the document suggest dealing with the challenges of keeping software engineers updated with current technologies and best practices?
