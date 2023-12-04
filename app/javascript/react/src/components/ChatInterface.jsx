import React, { useState, useEffect, useRef, useCallback } from "react";
import ChatMessage from "./chat/ChatMessage";
import UserTypingIndicator from "./chat/UserTypingIndicator";
import ChatInputField from "./chat/ChatInputField";

/**
 * `ChatInterface` is a functional component that renders a chat interface.
 *
 * @component
 *
 * @returns {React.Element} A React element that represents a chat interface.
 */
const ChatInterface = () => {
  const chatEndRef = useRef();
  const [chatMessages, setChatMessages] = useState([]);
  const [userInput, setUserInput] = useState("");
  const [isBotProcessing, setBotProcessingStatus] = useState(false);
  const [isUserTyping, setUserTypingStatus] = useState(false);
  const [typingTimeout, setTypingTimeout] = useState(null);

  // Fetch the initial bot response.
  const fetchBotResponse = async (question) => {
    if (!question) return;

    setBotProcessingStatus(true);
    try {
      const response = await fetch("/questions/ask", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify({ question }),
      });
      const data = await response.json();
      setChatMessages((existingMessages) => [
        ...existingMessages,
        {
          sender: "agent",
          content: data.content,
        },
      ]);
    } catch (error) {
      console.error("Failed to fetch bot response:", error);
    } finally {
      setBotProcessingStatus(false);
    }
  };

  // Handle the user message.
  const handleUserMessage = useCallback(() => {
    if (isBotProcessing || !userInput) return;
    const userMessage = {
      sender: "user",
      content: userInput,
    };
    setChatMessages((existingMessages) => [...existingMessages, userMessage]);
    setUserInput("");
    fetchBotResponse(userInput);
  }, [isBotProcessing, userInput]);

  // Effect to handle the smooth scrolling of the chat interface.
  useEffect(() => {
    chatEndRef.current?.scrollIntoView({
      behavior: "smooth",
    });
  }, [chatMessages]);

  return (
    <div className="flex min-h-screen w-full">
      <main className="flex flex-col w-full max-h-screen">
        <div className="flex-grow overflow-y-scroll">
          <div className="flex flex-col w-full space-y-4 p-4">
            {chatMessages.map((message, index) => (
              <ChatMessage
                key={index}
                sender={message.sender}
                content={message.content}
              />
            ))}
            <div ref={chatEndRef} />
          </div>
        </div>
        <UserTypingIndicator
          isTyping={isUserTyping}
          label="User is typing..."
        />
        <UserTypingIndicator isTyping={isBotProcessing} label="Thinking..." />
        <ChatInputField
          userInput={userInput}
          setUserInput={setUserInput}
          handleUserMessage={handleUserMessage}
          isBotProcessing={isBotProcessing}
          setUserTypingStatus={setUserTypingStatus}
          typingTimeout={typingTimeout}
          setTypingTimeout={setTypingTimeout}
        />
      </main>
    </div>
  );
};

export default ChatInterface;
