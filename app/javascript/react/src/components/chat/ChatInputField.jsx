import React from "react";
/**
 * `ChatInputField` is a functional component that renders a chat input field.
 *
 * @component
 * @param {Object} props - The properties passed to the component.
 * @param {string} props.userInput - The current user input.
 * @param {Function} props.setUserInput - Function to set the user input.
 * @param {Function} props.handleUserMessage - Function to handle the user message.
 * @param {boolean} props.isBotProcessing - A boolean indicating whether the bot is processing.
 * @param {Function} props.setUserTypingStatus - Function to set the user typing status.
 * @param {number} props.typingTimeout - The typing timeout.
 * @param {Function} props.setTypingTimeout - Function to set the typing timeout.
 *
 * @example
 * <ChatInputField userInput="Hello, World!" setUserInput={setUserInput} handleUserMessage={handleUserMessage} isBotProcessing={false} setUserTypingStatus={setUserTypingStatus} typingTimeout={1000} setTypingTimeout={setTypingTimeout} />
 *
 * @returns {React.Element} A React element that represents a chat input field.
 */
const ChatInputField = ({
  userInput,
  setUserInput,
  handleUserMessage,
  isBotProcessing,
  setUserTypingStatus,
  typingTimeout,
  setTypingTimeout,
}) => (
  <form
    onSubmit={(e) => {
      e.preventDefault();
      handleUserMessage();
    }}
    className="flex bg-neutral-200 p-4 space-x-4"
  >
    <textarea
      value={userInput}
      onChange={(e) => setUserInput(e.target.value)}
      onKeyUp={(e) => {
        if (e.key === "Enter") {
          handleUserMessage();
        }
        setTypingTimeout(setTimeout(() => setUserTypingStatus(false), 1000));
      }}
      onKeyDown={() => {
        setUserTypingStatus(true);
        clearTimeout(typingTimeout);
      }}
      className="rounded form-textarea px-2 flex-grow disabled:bg-gray-200"
      disabled={isBotProcessing}
    />
    <button
      className="bg-indigo-500 text-white px-6 text-sm disabled:bg-indigo-200"
      type="submit"
      disabled={isBotProcessing}
    >
      Send
    </button>
  </form>
);

export default ChatInputField;