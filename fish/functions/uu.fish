function uu -d 'Fuzzy-search Safari history'
	set -l columns (math "round $COLUMNS / 3")
	set -l separator "{::}"
	sqlite3 -separator $separator $HOME/Library/Safari/History.db \
		"select distinct substr(title, 1, $columns), url from history_items \
			inner join history_visits on history_items.id = history_visits.history_item \
			order by history_visits.visit_time desc;" | \
		awk -F $separator '{printf "%-'$columns's  \x1b[36m%s\x1b[m\n", $1, $2}' | \
		fzf --ansi --multi | sed 's#.*\(https*://\)#\1#' | xargs open
end
