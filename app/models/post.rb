class Post < ApplicationRecord
    validates :title, presence: :true
    validates :category, inclusion: {in: ["Fiction", "Non-Fiction"]}
    validates :content, length: {minimum: 100}

    # validate :title_click_baity

    def create
        post = Post.create!(post_params)
        render json: post, status: :created, status: 201
    end

    def title_click_baity
        if(!title_is_click_baity)
            errors.add(:title, "is not sufficiently clickbait-y")
        end
    end

    private
    def title_is_click_baity
        expected_matches = ["Won't Believe", "Secret", /Top \d+/i, "Guess"]
        return !expected_matches.find {|expected_match| self.title.match?(expected_match)}.nil?
    end
end
