# ChatGPT Prompt Engineering for Developers
    - by Andrew Ng
# <font color="red">Two types of Large Language Models(LLMs)</font> 
                                |
                                |
            ----------------------------------------
            |                                       |
            |                                       |
        Base LLM                            Instruction-Tuned LLM            

# <font color='blue'>  Base LLM </font>
    A Base LLM is trained using self-supervised learning, where it learns to predict the next token in a sequence. It develops a broad understanding of language but is not specifically trained to follow instructions.
Example Prompt: Translate "Hello" to French. <br>
Possible Base LLM Output: Translate "Hello" to French. <br>
Examples: 
Hello → Bonjour <br>
Good Morning → Bonjour <br>
Good Night → Bonne Nuit <br>
Notice that instead of directly answering, it may continue the text in the style of training data. <br>
Examples of Base LLMs:
* Llama (base versions)
* GPT-3 (original base models)
* Mistral (base variants)

# <font color='blue'> Instruction-Tuned LLM </font>
    An Instruction-Tuned LLM starts with a base LLM and is then fine-tuned on datasets containing instructions and high-quality responses. Many are further improved using techniques such as Reinforcement Learning from Human Feedback (RLHF) or preference optimization.
These models are designed to:
* Follow natural language instructions
* Answer questions directly
* Explain reasoning
* Write code
* Summarize documents
* Translate languages
* Engage in multi-turn conversations
# Analogy
    Base LLM = A person who has read millions of books and knows a great deal, but hasn't been trained to act as an assistant.

    Instruction-Tuned LLM = The same person after receiving customer service and communication training, so they understand requests and respond in a clear, helpful way.

![alt text](<imgaes/two types of llm.jpg>)

# Base LLM vs. Instruction-tuned LLM

![alt text](<imgaes/base vs instruction.jpg>)

