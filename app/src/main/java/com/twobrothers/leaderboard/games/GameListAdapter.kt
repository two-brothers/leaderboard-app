package com.twobrothers.leaderboard.games

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import androidx.recyclerview.widget.DiffUtil
import androidx.recyclerview.widget.ListAdapter
import androidx.recyclerview.widget.RecyclerView
import com.twobrothers.leaderboard.R
import com.twobrothers.leaderboard.games.models.Game


class GameListAdapter(
    private val onGameClickListener: OnGameClickListener?
) : ListAdapter<Game, GameListAdapter.ViewHolder>(DifferConfig()) {

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ViewHolder {
        val view = LayoutInflater.from(parent.context)
            .inflate(R.layout.view_game_item, parent, false)
        return ViewHolder(view)
    }

    override fun onBindViewHolder(holder: ViewHolder, position: Int) {
        holder.bind(getItem(position))
    }

    inner class ViewHolder(itemView: View) : RecyclerView.ViewHolder(itemView) {
        fun bind(game: Game) {
            itemView.findViewById<TextView>(R.id.text_title).text = game.title
            itemView.setOnClickListener {
                onGameClickListener?.onClick(game.id)
            }
        }
    }

    private class DifferConfig : DiffUtil.ItemCallback<Game>() {
        override fun areItemsTheSame(oldItem: Game, newItem: Game): Boolean {
            return oldItem.id == newItem.id
        }

        override fun areContentsTheSame(
            oldItem: Game,
            newItem: Game
        ): Boolean {
            return oldItem.id == newItem.id && oldItem.title == newItem.title
        }
    }

}

interface OnGameClickListener {
    fun onClick(id: String)
}