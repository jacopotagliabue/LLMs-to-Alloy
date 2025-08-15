# LLMs-to-Alloy
Example of LLM generated Alloy code for deductive reasoning from English descriptions.


## Overview

TBC

## Setup

TBC

## Prompts

*Image-based prompt (one shot)*

Upload image and prompt the chat with:

```text
Can you solve the question based on the situation: WHO IS MARTA (GIRLS ARE BETWEEN A-E) AND WHICH ONE IS HER CAR (CARS ARE BETWEEN 1-5)?
```

*Textual prompt (one shot)*

Just prompt the chat with:

```text
There are 5 cars arranged in a row, labeled 1 to 5, and 5 girls in a row, each one in front of a car, A-E, respecting the constraints below. So initially girl A is mapped to car 1, B to car 2 etc. There are 5 names for the girls, Bianca, Franca, Giovanna, Laura and Marta, but we don't know which girl owns which car and which girl has which name. Initially, they are not in front of the car they actually own.

These are the facts we know for sure:
Girl A said that Laura is not next to Girl A, and A's car is in front of Bianca. 
Girl B said that her car does not have a roof rack. Giovanna's car has a roof rack, and Giovanna is standing next to Bianca.
Girl C said that Bianca is wearing trousers. Bianca's car is in front of Franca.
Girl D said that Laura has a skirt, and Laura's car is in front of Girl D. 

We also know that:
Car 3 and car 5 have a roof rack, no other car has one
Girl A and Girl E wear trousers, everybody else wears a skirt 

Goal: to find which girl is Marta and which one is her car.
```

*Textual prompt (step by step with Alloy)*

```text
{text prompt describing the problem to start}
Do not try to solve the problem immediately. Start by only modelling the initial situation, with 5 cars and 5 unnamed girls in front of them, so that we can generate an example in the Alloy UI depicting some possible assignments BEFORE taking into consideration any of the statements made by the girls. Generate code with generous comments please, in one Alloy file.
```

## License

The code in this repository is provided "as is" and is licensed under the MIT License. See the [LICENSE](LICENSE) file for more details.