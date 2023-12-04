import React from "react";
/**
 * `UserTypingIndicator` is a functional component that renders a typing indicator.
 *
 * @component
 * @param {Object} props - The properties passed to the component.
 * @param {boolean} props.isTyping - A boolean indicating whether the user is typing.
 * @param {string} props.label - The label to display when the user is typing.
 *
 * @example
 * <UserTypingIndicator isTyping={true} label="User is typing..." />
 *
 * @returns {React.Element} A React element that represents a typing indicator, or null if `isTyping` is false.
 */
const UserTypingIndicator = ({ isTyping, label }) =>
  isTyping && <div className="text-neutral-500 p-2">{label}</div>;

export default UserTypingIndicator;
