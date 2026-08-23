import time
import random
import json
import os

script_dir = os.path.dirname(os.path.abspath(__file__))
json_path = os.path.join(script_dir, "activities.json")


def load_activities():
    with open(json_path, "r", encoding="utf-8") as file:
        return json.load(file)


ACTIVITIES = load_activities()

CLIENT_ID = "1541014364310605824"

try:
    from pypresence import Presence

    RPC = Presence(CLIENT_ID)
    RPC.connect()

    print("Successfully connected to Discord!")

    start_time = time.time()
    current_activity = random.choice(ACTIVITIES)

    while True:
        ACTIVITIES = load_activities()

        next_categories = current_activity.get("next_category", [])

        candidates = [
            act
            for act in ACTIVITIES
            if act != current_activity
            and (
                not next_categories
                or act.get("category") in next_categories
            )
        ]

        if not candidates:
            candidates = [
                act for act in ACTIVITIES
                if act != current_activity
            ]

        current_activity = random.choice(candidates)

        min_sec, max_sec = current_activity.get(
            "duration",
            [180, 420]
        )

        sleep_duration = random.randint(min_sec, max_sec)

        RPC.update(
            details=current_activity["details"],
            state=current_activity["state"],
            start=start_time,
            large_image="gtavi_logov4",
            large_text="Grand Theft Auto VI",
            small_image="rockstar_logo",
            small_text="Rockstar Games",
            buttons=[
                {
                    "label": "Watch Trailer 1",
                    "url": "https://www.youtube.com/watch?v=QdBZY2fkU-0"
                },
                {
                    "label": "Pre-order Game",
                    "url": "https://www.rockstargames.com/VI"
                }
            ]
        )

        minutes = round(sleep_duration / 60, 1)

        print(
            f"Status updated ({minutes} min): "
            f"{current_activity['details']} | "
            f"{current_activity['state']}"
        )

        time.sleep(sleep_duration)

except KeyboardInterrupt:
    print("\nStopping Rich Presence...")

except Exception as e:
    print(f"Error occurred: {e}")