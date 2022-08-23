require_relative './album'

class AlbumRepository

    def all
        sql = 'SELECT * FROM albums'
        arr = DatabaseConnection.exec_params(sql,[])
        arr = arr.map do |record|
            album = Album.new 
            album.id = record["id"]
            album.title = record["title"]
            album.release_year = record["release_year"]
            album.artist_id = record["artist_id"]
            record = album
        end

    end

    def find(id)
        #Execute SQL query
        #SELECT id, title, release_year, artist_id FROM albums WHERE id = id

        sql = "SELECT * FROM albums WHERE id = #{id}"
        arr = DatabaseConnection.exec_params(sql, [])
        album = Album.new 
        album.id = arr[0]["id"]
        album.title = arr[0]["title"]
        album.release_year = arr[0]["release_year"]
        album.artist_id = arr[0]["artist_id"]

        record = album

    end

    def create(album)
        #Execute SQL query
        #INSERT INTO albums VALUES (album.title, album.release_year, album.artist_id)
        sql = "INSERT INTO albums (title, release_year, artist_id) VALUES ('#{album.title}', #{album.release_year}, #{album.artist_id})"
        DatabaseConnection.exec_params(sql, [])
    end

    def update(id, album)
        # UPDATE albums 
        # SET title = album.title, release_year = album.release_year, artist_id = album.artist_id
        # WHERE id = id

        sql = "UPDATE albums SET title = '#{album.title}', release_year = #{album.release_year}, artist_id = #{album.artist_id} WHERE id = #{id}"
        DatabaseConnection.exec_params(sql, [])

    end

    def delete(id)
        sql = "DELETE FROM albums WHERE id = #{id}"
        DatabaseConnection.exec_params(sql, [])
    end
end
