package com.twobrothers.leaderboard.scores

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import androidx.recyclerview.widget.DiffUtil
import androidx.recyclerview.widget.ListAdapter
import androidx.recyclerview.widget.RecyclerView
import com.twobrothers.leaderboard.R
import com.twobrothers.leaderboard.games.models.ScoreCard


class ScoresListAdapter :
    ListAdapter<ScoreCard, ScoresListAdapter.ScoresListViewHolder>(ScoresListDifferConfig()) {

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ScoresListViewHolder {
        val view = LayoutInflater.from(parent.context)
            .inflate(R.layout.view_score_item, parent, false)
        return ScoresListViewHolder(view)
    }

    override fun onBindViewHolder(holder: ScoresListViewHolder, position: Int) {
        holder.bind(getItem(position))
    }

    inner class ScoresListViewHolder(itemView: View) : RecyclerView.ViewHolder(itemView) {
        fun bind(scoreCard: ScoreCard) {
            itemView.findViewById<TextView>(R.id.text_player_name).text = scoreCard.player.name
            itemView.findViewById<TextView>(R.id.text_score).text = scoreCard.score.toString()
        }
    }

    private class ScoresListDifferConfig : DiffUtil.ItemCallback<ScoreCard>() {
        override fun areItemsTheSame(oldItem: ScoreCard, newItem: ScoreCard): Boolean {
            return oldItem.id == newItem.id
        }

        override fun areContentsTheSame(
            oldItem: ScoreCard,
            newItem: ScoreCard
        ): Boolean {
            return oldItem.id == newItem.id
        }
    }

}