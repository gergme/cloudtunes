<?php

class LastFMArtwork {
        const API_KEY = "9535c3d2a107ed00cba8c3b930f1f82b";
        public static $sortedsizes = array("small" => 0, "medium" => 1, "large" => 2, "extralarge" => 3, "mega" => 4);
        public static function getArtwork($artist, $album, $return_image = false, $size = 'medium') {
                $artist = urlencode($artist);
                $album = urlencode($album);
                $xml    = "http://ws.audioscrobbler.com/2.0/?method=album.getinfo&artist={$artist}&album={$album}&api_key=" . self::API_KEY;
                $xml    = @file_get_contents($xml);
                
                if(!$xml) {
                        return 'http://localhost/noartwork.jpg';
                }
                
                $xml = new SimpleXMLElement($xml);
                $xml = $xml->album;
                $xml = $xml->image[self::$sortedsizes[$size]];

                return (!$return_image) ? $xml : $xml;
        }
}
?>
