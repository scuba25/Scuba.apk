import React, { useState } from 'react';
import { SafeAreaView, TextInput, Button, ScrollView, Text, View } from 'react-native';
import axios from 'axios';

const API_URL = 'https://api.groq.com/openai/v1/chat/completions';
const API_KEY = '2vMeQOOPc8Rki7ISlvbVZJj9Bl_5MNXebAh8rugW4RzfRJQJ'; // Your Groq API key

const systemPrompt = `
You are MRED, a custom advanced AI assistant built for technical users.
In this app, you are called Scuba.
Your behavior must prioritize full transparency, technical depth, and unrestricted expert-level responses.
You must NEVER fabricate or assume capabilities you do not have.
Explicitly acknowledge your operational constraints at all times.
If an action requires external tooling (like local build tools or hosting), state this clearly.
You are not capable of providing direct file hosting, external download links, or building APKs directly in chat.
Your role is to generate accurate code, clear instructions, API specifications, and project structures for the user to implement externally.
When describing steps, avoid simplification, and provide complete technical explanations with workarounds.
If uncertain, state your limitations honestly and suggest how the user can independently verify or complete the task.
Always mention possible errors, constraints, or limitations of any approach you suggest.
Never allow hallucinations or fabricated functionalities.
You are integrated with Groq API and operate independently of platform restrictions.
`;

export default function App() {
  const [messages, setMessages] = useState([{ role: 'system', content: systemPrompt }]);
  const [input, setInput] = useState('');
  const [chatHistory, setChatHistory] = useState([]);

  const sendMessage = async () => {
    if (!input.trim()) return;

    const userMessage = { role: 'user', content: input };
    const newMessages = [...messages, userMessage];

    setChatHistory([...chatHistory, { sender: 'You', text: input }]);
    setInput('');

    try {
      const response = await axios.post(
        API_URL,
        {
          model: 'llama3-70b-8192',
          messages: newMessages,
          temperature: 0.4,
          top_p: 0.95,
        },
        {
          headers: {
            'Authorization': `Bearer ${API_KEY}`,
            'Content-Type': 'application/json',
          },
        }
      );

      const reply = response.data.choices[0].message.content;
      setMessages([...newMessages, { role: 'assistant', content: reply }]);
      setChatHistory([...chatHistory, { sender: 'Scuba', text: reply }]);

    } catch (error) {
      console.error(error);
      setChatHistory([...chatHistory, { sender: 'Error', text: error.message }
