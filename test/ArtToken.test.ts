import { ethers } from 'hardhat';
import chai from "chai";
import chaiAsPromised from 'chai-as-promised';
import { ArtToken, ArtToken__factory } from '../typechain';

chai.use(chaiAsPromised);
const { expect } = chai;

describe('ArtToken', () => {
    let artToken: ArtToken;

    beforeEach(async () => {
        const factory = await ethers.getContractFactory("ArtToken") as ArtToken__factory;
        artToken = await factory.deploy("ArtToken", "ART", "https://localhost:3000");

        await artToken.deployed();
    })

    context("")
})
