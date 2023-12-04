import React from "react";
/**
 * `ChatMessage` is a functional component that renders a chat message.
 *
 * @component
 * @param {Object} props - The properties passed to the component.
 * @param {string} props.content - The content of the chat message.
 * @param {string} props.sender - The sender of the chat message. Can be either "user" or "BookBot".
 *
 * @example
 * <ChatMessage content="Hello, World!" sender="user" />
 *
 * @returns {React.Element} A React element that represents a chat message.
 */
const ChatMessage = ({ content, sender }) => (
  <div
    className={`flex self-${
      sender === "user" ? "end" : "start"
    } flex-col rounded-2xl p-4 bg-${
      sender === "user" ? "neutral-300" : "indigo-300"
    } rounded-${sender === "user" ? "br" : "bl"}-none max-w-xl justify-end`}
  >
    <h2 className="text-xs">{sender === "user" ? "User" : "BookBot"}</h2>
    <p>{content}</p>
  </div>
);

export default ChatMessage;
