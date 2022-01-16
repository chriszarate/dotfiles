from kitty.boss import Boss
from typing import List, Union

def main(args: List[str]):
    pass

from kittens.tui.handler import result_handler
@result_handler(no_ui=True)

def handle_result(args: List[str], answer: str, target_window_id: int, boss: Boss) -> None:
   def chosen(ans: Union[None, str, int]) -> None:
      if ans == 0:
         boss.new_tab()

      if isinstance(ans, int):
         for tab in boss.all_tabs:
            if tab.id == ans:
               boss.set_active_tab(tab)

   # Build a list of tabs
   tab_list = ()

   # Add an option to open a new tab
   tab_list = tab_list + ((0, '[New tab]'),)

   for t in boss.all_tabs:
      title = t.title

      # Indicate if there is more than 1 window
      count = len(t.windows)
      if count > 1:
         title = title + ' [{count} windows]'.format(count=count)

      # Mark the current tab with an indicator
      if t.id == boss.active_tab.id:
         title = title + ' [current tab]'

      tab_list = tab_list + ((t.id, title),)

   boss.choose_entry('Choose a tab to switch to', tab_list, chosen)
