require 'album_repository'

def reset_album_table
    seed_sql = File.read('spec/seeds.sql')
    connection = PG.connect({host: '127.0.0.1', dbname: 'music_library_test'})
    connection.exec(seed_sql)
end

describe AlbumRepository do 
    before(:each) do
        reset_album_table
    end

    #tests go here

    it "gets #all entries from the table" do
        repo = AlbumRepository.new
        albums = repo.all

        expect(albums.length). to eq 2
        expect(albums[0].id).to eq "1"
        expect(albums[0].title).to eq 'YES'
        expect(albums[0].release_year).to eq "1996"
        expect(albums[0].artist_id).to eq "4"
        expect(albums[1].id).to eq "2"
        expect(albums[1].title).to eq 'NO'
        expect(albums[1].release_year).to eq "1997"
        expect(albums[1].artist_id).to eq "5"

    end

    it "#finds a student by their id" do

        repo = AlbumRepository.new
        album = repo.find(1)

        expect(album.id).to eq "1"
        expect(album.title).to eq 'YES'
        expect(album.release_year).to eq "1996"
        expect(album.artist_id).to eq "4"
    end

    it "creates an entry to the table" do

        album = Album.new
        album.title = "New"
        album.release_year = 1998
        album.artist_id = 5

        repo = AlbumRepository.new
        repo.create(album)

        albums = repo.all

        expect(albums[-1].title).to eq "New"
        expect(albums[-1].release_year).to eq "1998"
        expect(albums[-1].artist_id).to eq "5"

    end

    it "updates and entry in the table" do

        album = Album.new
        album.title = "New"
        album.release_year = 1998
        album.artist_id = 5

        repo = AlbumRepository.new

        repo.update(2, album)

        updated_album = repo.find(2)

        expect(updated_album.title).to eq "New"
        expect(updated_album.release_year).to eq "1998"
        expect(updated_album.artist_id).to eq "5"

    end

    it "deletes an album from the table using its id" do

        repo = AlbumRepository.new

        repo.delete(1)

        albums = repo.all

        expect(albums.length).to eq 1
        expect(albums[0].id).to eq "2"
        expect(albums[0].title).to eq 'NO'
        expect(albums[0].release_year).to eq "1997"
        expect(albums[0].artist_id).to eq "5"
    end
end