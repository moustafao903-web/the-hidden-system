from core.runtime_state import RuntimeState


class TitleEngine:

    def __init__(self):
        self.runtime = RuntimeState()

    def run(self):

        book = self.runtime.get("book")
        market = self.runtime.get("market")

        return {
            "title": book["title"],
            "market_positioning": market["positioning"]["core_angle"]
        }


if __name__ == "__main__":
    engine = TitleEngine()
    print(engine.run())
python engines/title/engine.py