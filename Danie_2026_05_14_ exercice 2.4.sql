 --1.Le Rapport Lisible (La fin du RECHERCHEV)

--Je veux la liste de toutes les ventes, mais remplace les IDs par le nom du produit et le nom de la ville du magasin. Affiche aussi la date et la quantité--

 
SELECT
    v.date_vente,
    p.nom_produit,
    vi.nom_ville,
    v.quantite_vendue
FROM ventes AS v
INNER JOIN produits AS p
    ON v.id_produit = p.id_produit
INNER JOIN magasins AS m
    ON v.id_magasin = m.id_magasin
INNER JOIN villes AS vi
    ON m.id_ville = vi.id_ville;

-- 2. Focus Grand Kivu
-- On veut analyser les performances à l'Est. Donne-moi toutes les ventes (Nom produit, Prix, Quantité) réalisées uniquement dans les magasins de Goma et Bukavu--


SELECT
    p.nom_produit,
    p.prix,
    v.quantite_vendue,
    vi.nom_ville
FROM ventes AS v
INNER JOIN produits AS p
    ON v.id_produit = p.id_produit
INNER JOIN magasins AS m
    ON v.id_magasin = m.id_magasin
INNER JOIN villes AS vi
    ON m.id_ville = vi.id_ville
WHERE vi.nom_ville IN ('Goma', 'Bukavu');



--3. Top Katanga 
--À Lubumbashi, quels sont les produits de la catégorie 'Running' que nous avons vendus ? Je veux le nom des produits et le total des quantités vendues--


SELECT
    p.nom_produit,
    SUM(v.quantite_vendue) AS total_quantites
FROM ventes AS v
INNER JOIN produits AS p
    ON v.id_produit = p.id_produit
INNER JOIN categories AS c
    ON p.id_categorie = c.id_categorie
INNER JOIN magasins AS m
    ON v.id_magasin = m.id_magasin
INNER JOIN villes AS vi
    ON m.id_ville = vi.id_ville
WHERE vi.nom_ville = 'Lubumbashi'
AND c.nom_categorie = 'Running'
GROUP BY p.nom_produit;  

--4. La rentabilité par Magasin
--Mr Jhon veut savoir quel magasin a généré le plus de cash. Affiche le Nom du magasin, sa Ville et le Chiffre d'Affaires total.-- 


SELECT
    m.nom_magasin,
    vi.nom_ville,
    SUM(v.quantite_vendue * p.prix) AS chiffre_affaires_total
FROM ventes AS v
INNER JOIN produits AS p
    ON v.id_produit = p.id_produit
INNER JOIN magasins AS m
    ON v.id_magasin = m.id_magasin
INNER JOIN villes AS vi
    ON m.id_ville = vi.id_ville
GROUP BY m.nom_magasin, vi.nom_ville
ORDER BY chiffre_affaires_total DESC;

--5.5. L'inventaire des catégories par Ville
--Est-ce qu'on vend du 'Yoga' à Matadi ? Liste les noms des catégories vendues par ville, sans doublons.--


SELECT DISTINCT
    vi.nom_ville,
    c.nom_categorie
FROM ventes AS v
INNER JOIN produits AS p
    ON v.id_produit = p.id_produit
INNER JOIN categories AS c
    ON p.id_categorie = c.id_categorie
INNER JOIN magasins AS m
    ON v.id_magasin = m.id_magasin
INNER JOIN villes AS vi
    ON m.id_ville = vi.id_ville
ORDER BY vi.nom_ville, c.nom_categorie;