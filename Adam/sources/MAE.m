function [value] = MAE(ratings, predictions)

value = sum(abs(ratings - predictions))/length(ratings);

return
end