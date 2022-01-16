from kitty.boss import Boss
from kitty.tabs import Tab
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

   def format_tab_title(tab: Tab) -> str:
      title = tab.title
      count = len(tab.windows)

      if count > 1:
         title = f'{title} [{count} windows]'

      if tab.id == boss.active_tab.id:
         title = f'{title} [current tab]'

      return title

   boss.choose_entry(
       'Choose a tab to switch to',
       ((t.id, format_tab_title(t)) for t in boss.all_tabs),
       chosen
   )
