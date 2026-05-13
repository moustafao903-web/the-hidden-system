class PromptCompiler:

    @staticmethod
    def compile(engine_rules, runtime_context, task):

        prompt = f"""
SYSTEM RULES:
{engine_rules}

RUNTIME CONTEXT:
{runtime_context}

TASK:
{task}
"""

        return prompt