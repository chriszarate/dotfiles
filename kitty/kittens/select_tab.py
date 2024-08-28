from kitty.boss import Boss
from kitty.tabs import Tab
from kittens.tui.handler import result_handler
from kitty.window import Window
from typing import List, Union

def main(args: List[str]):
   pass

@result_handler(no_ui=True)
def handle_result(args: List[str], answer: str, target_window_id: int, boss: Boss) -> None:
   current_tab: Tab = boss.active_tab
   current_layout: str = current_tab.current_layout.name

   # Reset the layout to the previous layout without disrupting "last layout"
   def reset_layout() -> None:
      if current_layout != 'stack':
         current_tab.goto_layout(current_layout)

   def chosen(ans: Union[None, str, int]) -> None:
      if isinstance(ans, int):
         for tab in boss.all_tabs:
            if tab.id == ans:
               boss.set_active_tab(tab)
               break

      reset_layout()

   def format_tab_title(tab: Tab) -> str:
      title: str = tab.title

      if tab.id == boss.active_tab.id:
         title: str = f'{title} [current tab]'

      # Get all other non-active windows in the tab
      other_windows: List[Window] = []
      for w in tab.windows:
         if w.id != tab.active_window.id:
            other_windows.append(w)

      # Add the titles of the other windows underneath the tab title
      for w in other_windows:
         prefix: str = '└' if w.id == other_windows[-1].id else '├'
         title = f'{title}\r  {prefix}─ {w.title}'

      return title

   # Switch to the stack layout to display the tab list
   if current_layout != 'stack':
      current_tab.goto_layout('stack')

   boss.choose_entry(
      'Choose a tab to switch to or ESC to cancel',
      ((t.id, format_tab_title(t)) for t in boss.all_tabs),
      chosen
   )
