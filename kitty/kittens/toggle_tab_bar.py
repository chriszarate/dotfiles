from kitty.boss import Boss
from kitty.fast_data_types import get_options
from kittens.tui.handler import result_handler
from typing import List

def main(args: List[str]):
   pass

@result_handler(no_ui=True)
def handle_result(args: List[str], answer: str, target_window_id: int, boss: Boss) -> None:
   new_style = 'separator' if get_options().tab_bar_style == 'hidden' else 'hidden'

   # Reload config through kitty's canonical path with a tab_bar_style override.
   boss.load_config_file(overrides=(f'tab_bar_style {new_style}',))

   # apply_new_options re-layouts windows before mark_tab_bar_dirty tells the C
   # layer to reserve space for the bar, so on "show" the windows keep their
   # full-viewport size and cover the bar. Redo the layout in the right order
   # (same sequence as kitty's update_tab_bar_visibility decorator).
   for tm in boss.all_tab_managers:
      tm.layout_tab_bar()
      tm.resize(only_tabs=True)
