def count_xmas(grid):
    # Define the word to search for and its length
    word = "XMAS"
    word_len = len(word)

    # Define all possible directions to search for the word
    directions = [
        (0, 1),  # right
        (1, 0),  # down
        (1, 1),  # down-right
        (1, -1), # down-left
        (0, -1), # left
        (-1, 0), # up
        (-1, -1),# up-left
        (-1, 1)  # up-right
    ]

    # Check if a position is within the grid boundaries
    def is_valid(x, y):
        return 0 <= x < len(grid) and 0 <= y < len(grid[0])

    # Search for the word starting from a given position in a specific direction
    def search_from(x, y, dx, dy):
        for i in range(word_len):
            nx, ny = x + i * dx, y + i * dy
            if not is_valid(nx, ny) or grid[nx][ny] != word[i]:
                return False
        return True

    count = 0
    # Iterate over each cell in the grid
    for i in range(len(grid)):
        for j in range(len(grid[0])):
            # Check all directions from the current cell
            for dx, dy in directions:
                if search_from(i, j, dx, dy):
                    count += 1

    return count

# Read grid from input.txt
with open('input.txt', 'r') as file:
    grid = [line.strip() for line in file.readlines()]

# Print the count of occurrences of the word "XMAS"
print(count_xmas(grid))