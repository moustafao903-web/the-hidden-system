from pathlib import Path
import yaml


class RuntimeState:
    def __init__(self, runtime_file="runtime/current_book.yaml"):
        self.runtime_file = Path(runtime_file)
        self.data = self.load_runtime()

    def load_runtime(self):
        with open(self.runtime_file, "r", encoding="utf-8") as file:
            return yaml.safe_load(file)

    def get(self, key, default=None):
        return self.data.get(key, default)

    def reload(self):
        self.data = self.load_runtime()

    def current_engine(self):
        return self.data["runtime"]["current_engine"]

    def next_engine(self):
        return self.data["runtime"]["next_engine"]