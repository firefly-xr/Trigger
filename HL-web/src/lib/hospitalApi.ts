export interface RealHospital {
  id: string;
  name: string;
  lat: number;
  lng: number;
  tags: Record<string, string>;
}

/**
 * Fetches real-world hospitals near a given coordinate using OSM Overpass API.
 * @param lng Longitude
 * @param radius Radius in meters (default 10000m / 10km)
 * @returns Array of RealHospital objects
 */
export async function fetchNearbyHospitals(lat: number, lng: number, radius = 10000): Promise<RealHospital[]> {
  const query = `
    [out:json][timeout:10];
    (
      node(around:${radius},${lat},${lng})["amenity"="hospital"];
      node(around:${radius},${lat},${lng})["amenity"="clinic"];
      node(around:${radius},${lat},${lng})["healthcare"="hospital"];
    );
    out body;
  `;

  try {
    const response = await fetch('https://overpass-api.de/api/interpreter', {
      method: 'POST',
      body: query,
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded'
      }
    });

    if (!response.ok) {
      console.warn("Overpass API unavailable or rate-limited. Falling back to local data.");
      return [];
    }

    const data = await response.json();
    
    const hospitals: RealHospital[] = data.elements
      .filter((el: any) => el.tags && el.tags.name)
      .map((el: any) => ({
        id: el.id.toString(),
        name: el.tags.name,
        lat: el.lat,
        lng: el.lon,
        tags: el.tags
      }))
      .filter((h: any) => h.lat && h.lng) 
      .slice(0, 15);

    return hospitals;

  } catch (error) {
    console.error("Error fetching nearby hospitals:", error);
    return [];
  }
}
